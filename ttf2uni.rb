# experimental chinese tfm generator
# author: Hans Hagen / PRAGMA ADE

class TTFtoUnicode

    def initialize
        # nothing yet
    end

    def make_encoding_files
        print "encodings -> "
        for i in 0..255 do
            h = sprintf("%02x",i)
            print "#{h} "
            if f = File.open("uni-#{h}.enc",'w') then
                f << "/Unicode#{h.upcase}Encoding [\n"
                for ii in 0..255 do
                    hh = sprintf("%02x",ii)
                    f << "/uni#{h.upcase}#{hh.upcase}\n"
                end
                f << "] def\n"
                f.close
            end
        end
        print "\n"
    end

    def make_metric_files(base)
        afm = "#{base}.afm"
        ttf = "#{base}.ttf"
        map = "uni-#{base}.map"
        system("ttf2afm -u #{ttf} > #{afm}")
        if m = File.open(map,'w') then
            for i in 0..255 do
                h = sprintf("%02x",i)
                tfm = "uni-#{base}-#{h}.tfm"
                enc = "uni-#{h}.enc"
                line = `afm2tfm #{afm} -u -T #{enc} #{tfm}`
                if FileTest.file?(tfm) then
                    if FileTest.size(tfm)>0 then
                        m << line.chomp
                        m << " <#{ttf}"
                        m << "\n"
                        puts "#{base} -> #{h} -> ok\n"
                    else
                        File.delete(tfm)
                        puts "#{base} -> #{h} -> empty\n"
                    end
                end
            end
            m.close
        end
    end

end

files = ['htfs','hthei','htkai','htsong']

files = [(ARGV[0] || '').sub(/\.ttf$/,'')]

exit if files.size == 0

c = TTFtoUnicode.new
c.make_encoding_files
files.each do |base|
    c.make_metric_files(base)
end

