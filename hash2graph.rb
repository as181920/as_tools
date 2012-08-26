# encoding: utf-8
require "yaml"
require "graphviz"

class Hash
  def generate_graphviz(out_file)
    graph = GraphViz.new(:G, type: "digraph")
    graph.graph[:rankdir=>:LR]
    graph.add self
    #draw_nodes_edges(graph,self)
    graph.output(png: out_file)
  end
end

unless ARGV.length==1 and File.file? ARGV[0]
  puts <<-USAGE
Usage: ruby yaml_file_name
Example: ruby file1.yml
USAGE
else
  #puts File.dirname(__FILE__)+"/"+ARGV[0]
  print "read data from file: ",ARGV[0],"\n"
  hash = YAML::load(File.open ARGV[0])
  print "generate graph: x.png\n"
  hash.generate_graphviz("x.png")
end

