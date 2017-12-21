module DiagnosisLogsHelper
  def class_row_result(result)
    if result == 'fail'
      'danger'
    else
      result
    end
  end
end
