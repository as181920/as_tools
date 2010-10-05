require "graphviz"
gvr = GraphViz.new :G, :type=>:digraph
gvr.graph[:rankdir=>:LR]
#gvr.graph[:rankdir=>:TB]
gvr.node[:shape=>:box]

gvr.typeofcount[:label=>"Determine\nType of\nCount"]
gvr.scopeandboundary[:label=>"Identify\nCounting\nScope and\nApplication\nBoundary"]
gvr.datafounctions[:label=>"Count Data\nFunctions"]
gvr.transactionalfounctions[:label=>"Count\nTransactional\nFunctions"]
gvr.unadjusted[:label=>"Determine\nUnadjusted\nFunction Point\nCount"]
gvr.adjustmentfactor[:label=>"Determine Value\nAdjustment\nFactor"]
gvr.adjusted[:label=>"Calculate\nAdjusted Function\nPoint Count"]

gvr.typeofcount>>gvr.scopeandboundary
gvr.scopeandboundary>>gvr.datafounctions
gvr.scopeandboundary>>gvr.transactionalfounctions
gvr.datafounctions>>gvr.unadjusted
gvr.transactionalfounctions>>gvr.unadjusted
gvr.scopeandboundary>>gvr.adjustmentfactor
gvr.unadjusted>>gvr.adjusted
gvr.adjustmentfactor>>gvr.adjusted

gvr.output(:png=>"fp_procedure.png")
