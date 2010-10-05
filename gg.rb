require "graphviz"
gvr = GraphViz.new :G, :type=>:digraph
#gvr.graph[:rankdir=>:LR]
gvr.graph[:rankdir=>:TB]

gvr.cluster1 do |c1|
  c1.graph[:label=>"Achieve Specific Goals",:style=>:bold]
  c1.node[:shape=>:box]

  c1.gp11[:label=>"Perform Specific Pratices"]
end

gvr.cluster2 do |c2|
  #c2.graph[:label=>"GG2",:style=>:bold,:rankdir=>:TB]
  c2.graph[:label=>"Institutionalize a Managed Process",:style=>:bold]
  c2.node[:shape=>:box]

  c2.gp21[:label=>"Establish an Organizational Policy"]
  c2.gp22[:label=>"Plan the process"]
  c2.gp23[:label=>"Provide Resources"]
  c2.gp24[:label=>"Assign Responsibility"]
  c2.gp25[:label=>"Train People"]
  c2.gp26[:label=>"Manage Configurations"]
  c2.gp27[:label=>"Identify and Involve Relevant Stakeholders"]
  c2.gp28[:label=>"Monitor and Control the Process"]
  c2.gp29[:label=>"Objectively Evaluate Adherence"]
  c2.gp210[:label=>"Review Status with Higher Level Management"]

  (c2.gp21>>c2.gp22)[:dir=>:none]
  (c2.gp22>>c2.gp23)[:dir=>:none]
  (c2.gp23>>c2.gp24)[:dir=>:none]
  (c2.gp24>>c2.gp25)[:dir=>:none]
  (c2.gp25>>c2.gp26)[:dir=>:none]
  (c2.gp26>>c2.gp27)[:dir=>:none]
  (c2.gp27>>c2.gp28)[:dir=>:none]
  (c2.gp28>>c2.gp29)[:dir=>:none]
  (c2.gp29>>c2.gp210)[:dir=>:none]
end

gvr.cluster3 do |c3|
  c3.graph[:label=>"Institutionalize a Defined Process",:style=>:bold]
  c3.node[:shape=>:box]

  c3.gp31[:label=>"Establish a Defined Process"]
  c3.gp32[:label=>"Collect Improvement Information"]

  (c3.gp31>>c3.gp32)[:dir=>:none]
end

gvr.cluster4 do |c4|
  c4.graph[:label=>"Institutionalize a Quantitatively Managed Process",:style=>:bold]
  c4.node[:shape=>:box]

  c4.gp41[:label=>"Establish Quantitative Objectives for the Process"]
  c4.gp42[:label=>"Stabilize Subprocess Performance"]

  (c4.gp41>>c4.gp42)[:dir=>:none]
end

gvr.cluster5 do |c5|
  c5.graph[:label=>"Institutionalize an Optimizing Process",:style=>:bold]
  c5.node[:shape=>:box]

  c5.gp51[:label=>"Ensure Continuous Process Improvement"]
  c5.gp52[:label=>"Correct Root Causes of Problems"]

  (c5.gp51>>c5.gp52)[:dir=>:none]
end

gvr.output(:png=>"gg.png")
#gvr.output(:jpg=>"x.jpg")
