require "graphviz"
gvr = GraphViz.new :G, :type=>:digraph
gvr.graph[:rankdir=>:LR]
#gvr.graph[:rankdir=>:TB]

gvr.cluster1 do |c1|
  c1.graph[:label=>"IDEAL",:style=>:bold]
  c1.node[:shape=>:circle]
  c1.node[:color=>:blue]
  c1.node[:fontcolor=>:red]
  #c1.edge[:color] = "#666666"  

  c1.Initiating>>c1.Diagnosing>>c1.Establishing>>c1.Acting>>c1.Learning>>c1.Initiating
end

gvr.output(:png=>"ideal.png")
