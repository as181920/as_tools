require "graphviz"
gvr = GraphViz.new :G, :type=>:digraph
#gvr.graph[:rankdir=>:LR]
gvr.graph[:rankdir=>:TB]

gvr.org[:label=>"Organization",:shape=>:box]
gvr.smg[:label=>"Senior\nmanagement",:shape=>:box]

gvr.cluster_process_management do |psm|
  psm.graph[:label=>"Process Management",:style=>:bold]
  psm.node[:shape=>:ellipse]

  psm.cluster_basic_psm_pas do |basic|
    basic.graph[:label=>"Basic Process Management process areas",:style=>:bold]

    basic.opd[:label=>"OPD+IPPD"]
    basic.ot[:label=>"OT"]
    basic.opf[:label=>"OPF"]
    #basic.pjm_sup_eng1[:label=>"Project Management,\nSupport,and Engineering\nprocess areas",:shape=>:hexagon]
    basic.pjm_sup_eng1[:label=>"Project Management,\nSupport,and Engineering\nprocess areas",:shape=>:box]
    #basic.pjm_sup_eng1[:label=>"Project Management,\nSupport,and Engineering\nprocess areas",:shape=>:plaintext]

    (gvr.smg>>basic.opf)[:label=>"Organization's\nbusiness\nobjectives"]
    (basic.opf>>basic.opd)[:label=>"Resources and\ncoordination"]
    (gvr.org>>basic.ot)[:label=>"Organization's\nprocess needs\nand objetives"]
    (basic.opf>>basic.pjm_sup_eng1)[:label=>""]
    (basic.opd>>basic.ot)[:label=>"Standard process\nand\nother assets"]
    (basic.opd>>basic.pjm_sup_eng1)[:label=>"Standard process,work\nenvironment standards,\nand other assets"]
    (basic.ot>>basic.pjm_sup_eng1)[:label=>"Training for projets and\nsupport groups in standard\nprocess and assets"]
    (basic.pjm_sup_eng1>>basic.ot)[:label=>"Training needs"]
    (basic.pjm_sup_eng1>>basic.opd)[:label=>"improvement information"]
    (basic.pjm_sup_eng1>>basic.opf)[:label=>"Process-improvement proposals,\nparticipation in defining,assessing,\nand deploying processes"]
  end

  psm.cluster_advanced_psm_pas do |advanced|
    advanced.graph[:label=>"Advanced Process Management process areas",:style=>:bold]

    advanced.oid[:label=>"OID"]
    advanced.opp(:label=>"OPP")
    advanced.pjm_sup_eng2[:label=>"Project Management,\nSupport,and Engineering\nprocess areas",:shape=>:box]
    advanced.basic_psm_pas[:label=>"Basic\nProcess Management\nprocess areas",:shape=>:box]

    (advanced.oid>>gvr.org)[:label=>"improvements"]
    (advanced.opp>>gvr.smg)[:label=>"Progress toward\nachieving\nbusiness objetives"]
    (advanced.opp>>advanced.oid)[:label=>"Quality and process\nperformance objetives,\nmeasures,baselines,\nand models"]
    (advanced.opp>>advanced.pjm_sup_eng2)[:label=>"Quality and process-\nperformance objetives,\nmeasures,baselines,\nand models"]
    (advanced.opp>>advanced.basic_psm_pas)[:label=>""]
    (advanced.pjm_sup_eng2>>advanced.oid)[:label=>"Cost and benefit\ndata from piloted\nimprovements"]
    (advanced.pjm_sup_eng2>>advanced.opp)[:label=>"Process performance\nand capability data"]
    (advanced.basic_psm_pas>>advanced.opp)[:label=>"Common\nmeasures"]
    (advanced.basic_psm_pas>>advanced.oid)[:label=>"Ability to develop and\ndeploy standard process\nand other assets"]
  end
end

gvr.cluster_project_management do |pjm|
  pjm.graph[:label=>"Project Management",:style=>:bold]
  pjm.node[:shape=>:ellipse]

  pjm.cluster_basic_pjm_pas do |basic|
    basic.graph[:label=>"Basic Project Management process areas",:style=>:bold]

    basic.pp[:label=>"PP"]
    basic.pmc[:label=>"PMC"]
    basic.sam[:label=>"SAM"]
    basic.eng_sup1[:label=>"Engineering and Support\nprocess areas",:shape=>:box]
    basic.supplier[:label=>"Supplier",:shape=>:box]

    (basic.pp>>basic.pmc)[:label=>"What\nto monitor"]
    (basic.pp>>basic.eng_sup1)[:label=>"What to do,and\nMeasurement needs"]
    (basic.pp>>basic.sam)[:label=>"Plans",:dir=>:none]
    (basic.supplier>>basic.sam)[:label=>"Supplier\nagreement",:dir=>:none]
    (basic.sam>>basic.pmc)[:label=>"Status,issues,\nand results of\nreviews and monitoring"]
    (basic.sam>>basic.eng_sup1)[:label=>"Product component requirements,\ntechnical issues,completed product\ncomponents,and acceptance reviews\nand tests",:dir=>:none]
    (basic.pmc>>basic.sam)[:label=>"Corrective action"]
    (basic.pmc>>basic.eng_sup1)[:label=>"Corrective action"]
    (basic.pmc>>basic.pp)[:label=>"Replan"]
    (basic.eng_sup1>>basic.pmc)[:label=>"Status,issues,and results of process and\nproduct evaluations,measures and analyses"]
    (basic.eng_sup1>>basic.pp)[:label=>"What to build"]
    (basic.eng_sup1>>basic.pp)[:label=>"Commitments",:dir=>:none]
  end

  pjm.cluster_advanced_pjm_pas do |advanced|
    advanced.graph[:label=>"Advanced Project Management process areas",:style=>:bold]

    advanced.ipm[:label=>"IPM+IPPD"]
    advanced.qpm[:label=>"QPM"]
    advanced.rskm[:label=>"RSKM"]
    advanced.psm[:label=>"Process Management\nprocess areas",:shape=>:box]
    advanced.eng_sup2[:label=>"Engineering and Support\nprocess areas",:shape=>:box]
    advanced.basic_pjm_pas[:label=>"Basic\nProject Management\nprocess areas",:shape=>:box]

    (advanced.ipm>>advanced.rskm)[:label=>"Identified risks"]
    (advanced.ipm>>advanced.basic_pjm_pas)[:label=>"Project's shared version\nProject performance data"]
    (advanced.ipm>>advanced.eng_sup2)[:label=>"Project's defined process and work environment\nCoordination,commitments,and issues to resolve\nIntegrated teams for perfomrming engineering and support processes"]
    (advanced.ipm>>advanced.psm)[:label=>""]
    (advanced.psm>>advanced.qpm)[:label=>"Process performance\nobjectives,baselines,\nand models"]
    (advanced.psm>>advanced.ipm)[:label=>"Organization's standard processes,\nwork environment standards,\nand support assets"]
    (advanced.psm>>advanced.ipm)[:label=>"IPPD rules and guidlines"]
    (advanced.qpm>>advanced.psm)[:label=>"Statistical management data"]
    (advanced.qpm>>advanced.rskm)[:label=>"Risk exposure due to\nunstable processes"]
    (advanced.qpm>>advanced.basic_pjm_pas)[:label=>"Project's composed and defined process"]
    (advanced.qpm>>advanced.ipm)[:label=>"Quantitative objetives,subprocesses\nto statistically manage,project's\ncomposed,and defined process"]
    (advanced.rskm>>advanced.basic_pjm_pas)[:label=>"Risk taxonomies and\nparameters,risk\nstatus,risk mitigation\nplans,and corrective action"]
    (advanced.eng_sup2>>advanced.ipm)[:label=>"Product architecture for structuning teams\nLessons learned,planning and\nperfomance data"]
  end
end

gvr.cluster_engineering do |eng|
  eng.graph[:label=>"Engineering",:style=>:bold]
  eng.node[:shape=>:ellipse]

  eng.reqm[:label=>"REQM"]

  eng.cluster_engineering_sub do |subeng|
    subeng.rd[:label=>"RD"]
    subeng.ts[:label=>"TS"]
    subeng.pi[:label=>"PI"]
    subeng.customer[:label=>"Customer",:shape=>:box]
    subeng.ver[:label=>"VER"]
    subeng.val[:label=>"VAL"]

    (subeng.rd>>subeng.ts)[:label=>"Requirements"]
    (subeng.ts>>subeng.pi)[:label=>"Product components"]
    (subeng.pi>>subeng.customer)[:label=>"Product"]
    (subeng.ts>>subeng.ver)[:label=>"",:dir=>:none]
    (subeng.pi>>subeng.val)[:label=>"",:dir=>:none]
    (subeng.ts>>subeng.rd)[:label=>"Alternative solutions"]
    (subeng.pi>>subeng.rd)[:label=>"Product components,work products"]
    (subeng.ver>>subeng.rd)[:label=>"verification reports"]
    (subeng.val>>subeng.rd)[:label=>"validation reports"]
    (subeng.customer>>subeng.rd)[:label=>"Customer needs"]

    (subeng.rd>>eng.reqm)[:label=>"Product and product\ncomponent requirements"]
    # todo reqm to cluster:cluster_engineering_sub
    # (eng.reqm>>subeng.customer)[:label=>"Requirements",:lhead=>:cluster_engineering_sub]
  end
end

gvr.cluster_support do |sup|
  sup.graph[:label=>"Support",:style=>:bold]
  sup.node[:shape=>:ellipse]

  sup.cluster_basic_sup do |basic|
    basic.graph[:label=>"Basic Support Process Areas",:style=>:bold]

    basic.ma[:label=>"MA"]
    basic.cm[:label=>"CM"]
    basic.ppqa[:label=>"PPQA"]
    basic.all_pas1[:label=>"All process areas",:shape=>:box]

    (basic.ma>>basic.all_pas1)[:label=>"Measurements\nand analyses"]
    (basic.all_pas1>>basic.ma)[:label=>"Information needs"]
    (basic.all_pas1>>basic.cm)[:label=>"Configuration items\nand\nchange requests"]
    (basic.all_pas1>>basic.ppqa)[:label=>"Processes and\nwork products,\nand standards,and\nprocedures"]
    (basic.cm>>basic.all_pas1)[:label=>"Baselines and\naudit reports"]
    (basic.ppqa>>basic.all_pas1)[:label=>"Quality and\nnoncompliance issues"]
  end

  sup.cluster_advanced_sup do |advanced|
    advanced.graph[:label=>"Advanced Support Process Areas",:style=>:bold]

    advanced.all_pas2[:label=>"All process areas"]
    advanced.car[:label=>"CAR"]
    advanced.dar[:label=>"DAR"]

    (advanced.car>>advanced.all_pas2)[:label=>"Process improvement\nproposals"]
    (advanced.all_pas2>>advanced.car)[:label=>"Defect and\nother problems"]
    (advanced.all_pas2>>advanced.dar)[:label=>"Selectd\nissues"]
    (advanced.dar>>advanced.all_pas2)[:label=>"Formal\nevaluations"]
  end
end

gvr.output(:png=>"cmmi.png")
