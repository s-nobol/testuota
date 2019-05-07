module ApplicationHelper
  
  
  # 月ごとに振り分ける
  def ymconv(yyyymm,cnt)
    yyyy = yyyymm[0,4]
    mm = yyyymm[4,2]
    return yyyy + "年" + mm + "月 (" + cnt + ")"
  end
end
