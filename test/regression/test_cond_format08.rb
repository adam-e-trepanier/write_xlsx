# -*- coding: utf-8 -*-
require 'helper'

class TestRegressionCondFormat08 < Test::Unit::TestCase
  def setup
    setup_dir_var
  end

  def teardown
    File.delete(@xlsx) if File.exist?(@xlsx)
  end

  def test_cond_format08
    @xlsx = 'cond_format08.xlsx'
    workbook  = WriteXLSX.new(@xlsx)
    worksheet = workbook.add_worksheet

    format = workbook.add_format(
                                 :color         => '#9C6500',
                                 :bg_color      => '#FFEB9C',
                                 :font_condense => 1,
                                 :font_extend   => 1
                                 )

    worksheet.write('A1', 10)
    worksheet.write('A2', 20)
    worksheet.write('A3', 30)
    worksheet.write('A4', 40)

    worksheet.conditional_formatting('A1',
                                     {
                                       :type     => 'cell',
                                       :format   => format,
                                       :criteria => 'greater than',
                                       :value    => 5
                                     }
                                     )

    workbook.close
    compare_xlsx_for_regression(
                                File.join(@regression_output, @xlsx),
                                @xlsx,
                                nil,
                                { 'xl/workbook.xml' => ['<workbookView'] })
  end
end
