module ApplicationHelper
  
  # Dataを文字列に変換
  def year_month(yyyymm)
    yyyy = yyyymm[0].to_s[0,4]
    
    # 10より大きい場合
    if yyyymm[1] >= 10
      mm = yyyymm[1].to_s[0,2]
    else
      mm = "0"+yyyymm[1].to_s[0,1]
    end
    yyyymms =  yyyy+mm
    
    return yyyy, mm , yyyymms
  end
  
    
  # 月ごとに振り分ける(テスト用)
  def ymconv(yyyymm,cnt)
    yyyy = yyyymm[0,4]
    mm = yyyymm[4,2]
    return yyyy + "年" + mm + "月 (" + cnt + ")"
  end
end
