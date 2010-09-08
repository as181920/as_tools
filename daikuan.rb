require "ruport"
require "fox16"
# require "jcode"
include Fox

# $KCODE = ''

class DaiKuan < FXMainWindow
  def initialize(app,title,w,h)
    super(app,title,:width=>w,:height=>h)
    add_tool_bar
    add_input_area
    add_output_textarea
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  private
  def add_tool_bar
    menubar = FXMenuBar.new(self,LAYOUT_SIDE_RIGHT | LAYOUT_FILL_Y)

    mp_calculate = FXMenuPane.new(self)
    # mpname = "calculate"
    mpname = "计算"
    FXMenuTitle.new(menubar,mpname,:popupMenu => mp_calculate)
    mcname = "每月还款"
    mc_return_everymonth = FXMenuCommand.new(mp_calculate,mcname)
    mc_return_everymonth.connect(SEL_COMMAND) do
      interest = @tx_interest.text.to_f
      amount = @tx_amount.text.to_i
      years = @tx_years.text.to_i
      type = @cob_huankuan_type.text
      # result = Calculate.execute(mcname,interest,amount,years)
      result = calculate_everymonth(type,interest,amount,years)
      @tx_result.text = result
    end
    mcname = "每年还款"
    mc_return_everyyear = FXMenuCommand.new(mp_calculate,mcname)
    mc_return_everyyear.connect(SEL_COMMAND) do
      @tx_result.text = "功能尚未完成"
    end

    mp_export = FXMenuPane.new(self)
    mpname = "导出"
    FXMenuTitle.new(menubar,mpname,:popupMenu => mp_export)
    mcname = "导出text"
    mc_export_text = FXMenuCommand.new(mp_export,mcname)
    mc_export_text.connect(SEL_COMMAND) do
      dialog = FXFileDialog.new(self,"Write to File")
      dialog.patternList = ["Text Files (*.txt)","All Files (*)"]
      if dialog.execute != 0 then
        write_to_text(dialog.filename)
      end
    end
    mcname = "导出CSV"
    mc_export_csv = FXMenuCommand.new(mp_export,mcname)
    mc_export_csv.connect(SEL_COMMAND) do
      dialog = FXFileDialog.new(self,"Write to File")
      dialog.patternList = ["CSV Files (*.csv)","All Files (*)"]
      if dialog.execute != 0 then
        write_to_csv(dialog.filename)
      end
    end
    mcname = "导出html"
    mc_export_html = FXMenuCommand.new(mp_export,mcname)
    mc_export_html.connect(SEL_COMMAND) do
      dialog = FXFileDialog.new(self,"Write to File")
      dialog.patternList = ["html Files (*.html)","All Files (*)"]
      if dialog.execute != 0 then
        write_to_html(dialog.filename)
      end
    end
    mcname = "导出pdf"
    mc_export_pdf = FXMenuCommand.new(mp_export,mcname)
    mc_export_pdf.connect(SEL_COMMAND) do
      dialog = FXFileDialog.new(self,"Write to File")
      dialog.patternList = ["pdf Files (*.pdf)","All Files (*)"]
      if dialog.execute != 0 then
        write_to_pdf(dialog.filename)
      end
    end

    mp_clear = FXMenuPane.new(self)
    # mpname = "setting"
    mpname = "清空"
    FXMenuTitle.new(menubar,mpname,:popupMenu => mp_clear)
    mcname = "清空输出"
    mc_clear_output = FXMenuCommand.new(mp_clear,mcname)
    mc_clear_output.connect(SEL_COMMAND) do
      @tx_result.text = ""
    end
    mcname = "清空输入"
    mc_clear_input = FXMenuCommand.new(mp_clear,mcname)
    mc_clear_input.connect(SEL_COMMAND) do
      @tx_interest.text = ""
      @tx_amount.text = ""
      @tx_years.text = ""
    end
    mcname = "载入默认"
    mc_clear_default = FXMenuCommand.new(mp_clear,mcname)
    mc_clear_default.connect(SEL_COMMAND) do
      @tx_interest.text = "0.0387"
      @tx_amount.text = "400000"
      @tx_years.text = "15"
    end

    mp_help = FXMenuPane.new(self)
    mpname = "帮助"
    FXMenuTitle.new(menubar,mpname,:popupMenu => mp_help)
    mcname = "参考信息"
    mc_information = FXMenuCommand.new(mp_help,mcname)
    mc_information.connect(SEL_COMMAND) do
      @tx_result.text = $information
    end
    mcname = "填写指南"
    mc_manual = FXMenuCommand.new(mp_help,mcname)
    mc_manual.connect(SEL_COMMAND) do
      @tx_result.text = $manual
    end
    # this area is for test and debug
    mcname = "调试用"
    mc_test = FXMenuCommand.new(mp_help,mcname)
    mc_test.connect(SEL_COMMAND) do
      @tx_result.text = @cob_huankuan_type.text
    end

    mp_exit = FXMenuPane.new(self)
    mpname = "退出"
    FXMenuTitle.new(menubar,mpname,:popupMenu => mp_exit)
    mcname = "退出"
    mc_exit = FXMenuCommand.new(mp_exit,mcname)
    mc_exit.connect(SEL_COMMAND) do
      exit
    end
  end

  def add_input_area
    packer_input = FXPacker.new(self,:opts=> LAYOUT_SIDE_RIGHT)
    lb_daikuan_type = FXLabel.new(packer_input,"贷款类型",:opts=>JUSTIFY_LEFT)
    @tx_daikuan_type = FXText.new(packer_input)
    @tx_daikuan_type.text = "公积金贷款\n普通商贷"
    @tx_daikuan_type.editable = false
    lb_huankuan_type = FXLabel.new(packer_input,"还款类型",:opts=>JUSTIFY_LEFT)
=begin
    @tx_huankuan_type = FXText.new(packer_input)
    @lst_huankuan_type = FXList.new(packer_input)
    @lst_huankuan_type.appendItem("xxx")
    @lst_huankuan_type.appendItem("xx")
=end
    @cob_huankuan_type = FXComboBox.new(packer_input,8)
    @cob_huankuan_type.appendItem("等额本金")
    @cob_huankuan_type.appendItem("等额本息")
    lb_interest = FXLabel.new(packer_input,"利息率",:opts=>JUSTIFY_LEFT)
    @tx_interest = FXText.new(packer_input)
    @tx_interest.text = "0.0387"
    lb_amount = FXLabel.new(packer_input,"贷款额度",:opts=>JUSTIFY_LEFT)
    @tx_amount = FXText.new(packer_input)
    @tx_amount.text = "400000"
    lb_years = FXLabel.new(packer_input,"还款年数",:opts=>JUSTIFY_LEFT)
    @tx_years = FXText.new(packer_input)
    @tx_years.text = "15"
  end

  def add_output_textarea
    packer_output = FXPacker.new(self,:opts=> LAYOUT_SIDE_RIGHT|LAYOUT_FILL)
    @tx_result = FXText.new(packer_output,:opts=>TEXT_WORDWRAP|LAYOUT_FILL)
  end

  def calculate_everymonth(type,interest,amount,years)
    return "功能尚未完成" unless type == "等额本金"
    raise "输入数据有误，请修改后再计算" unless check_data_validation
    @result_table = Ruport::Data::Table.new :column_names => %w[月度 本金 利息 还款额], :data =>[]
    cnt_month = 0
    cnt_months = 12*years
    cnt_months.times do |cnt|
      cnt_month += 1
      benjin = (amount.to_f/cnt_months).round
      lixi = ((amount - cnt*benjin)*interest/12).round
      huankuane = benjin + lixi
      data = cnt_month,benjin,lixi,huankuane
      @result_table << data
    end
    @result_group = @result_table.to_group "每月还款明细"
    result = @result_group.to_s
    result << "\n"
    result << "累计还款金额:#{@result_table.sigma(3)}\n"
    return result
  rescue Exception => e
    errormsg = "发生错误，可能是输入数据有误。\n"
    errormsg << "错误信息如下：\n"
    errormsg << e.message
    errormsg << "\n"
    errormsg << "错误位置如下：\n"
    errormsg << e.backtrace.inspect
  end

  # TODO: add input data validation
  def check_data_validation
    if @tx_interest.text.to_f > 0 and 
      @tx_interest.text.to_f < 0.1 and
      @tx_amount.text.to_i >= 1000 and
      @tx_years.text.to_i >= 1 then
      tf = true
    else
      tf = false
    end
    return tf
  end

  def write_to_text(filename)
    File.open(filename,"w") do |f|
      # f.write @tx_result.text
      f.write @result_group
      f.write "\n"
      f.write "累计还款金额:#{@result_table.sigma(3)}\n"
    end
  end

  def write_to_csv(filename)
    File.open(filename,"w") do |f|
      f.write @result_group.to_csv
      f.write "\n"
      f.write "累计还款金额:#{@result_table.sigma(3)}\n"
    end
  end

  def write_to_html(filename)
    File.open(filename,"w") do |f|
      f.write @result_group.to_html
      f.write "\n"
      f.write "累计还款金额:#{@result_table.sigma(3)}\n"
    end
  end

  def write_to_pdf(filename)
    File.open(filename,"w") do |f|
      f.write @result_group.to_pdf
    end
  end
end

$information = <<EOF
目前公积金贷款的利息率为0.0387
目前普通商业贷款的利息率为0.0594
一般选择的还款年数有15、20年
EOF

$manual = <<EOF
1，选择还款类型
2，输入利息率，常用利息率请参考常规信息。应为小数格式。
3，输入贷款额度，应为>1w的整数。
4，输入还款年数，应为>0并且为1／12的整数倍
EOF

app = FXApp.new
$title = "Andersen's loan calculational tool"
# $title = "贷款计算器"
$width = 450
$height = 600
DaiKuan.new(app,$title,$width,$height)
app.create
app.run

# TODO
# 1，重购计算部分，支持其它前段
# 2，支持数据到处保存，包括各类型
