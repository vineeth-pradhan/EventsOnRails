module DateValidation
  def validate? hash
    bool = []
    bool << valid_startime?(hash[:starttime]) if hash[:starttime].present?
    bool << valid_endtime?(hash[:endtime]) if hash[:endtime].present?
    bool.all?
  end

  def valid_startime? starttime
    !Chronic.parse(starttime).nil?
  end

  def valid_endtime? endtime 
    !Chronic.parse(endtime).nil?
  end
end
