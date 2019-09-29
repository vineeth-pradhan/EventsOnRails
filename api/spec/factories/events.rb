FactoryBot.define do
  factory :future_event, class: Event do
    title "Philadelphia maki Fest"
    starttime "2020-09-27 11:47:08"
    endtime "2020-09-28 11:47:08"
    description "Maki"
    allday false
    complete false
  end

  factory :event_with_endtime, class: Event do
    title "Philadelphia maki Fest"
    starttime "2019-09-27 11:47:08"
    endtime "2019-09-27 11:47:08"
    description "Maki"
    allday false
    complete false
  end

  factory :allday_event, class: Event do
    title "Philadelphia maki Fest"
    starttime "2019-09-27 11:47:08"
    endtime "2019-09-27 11:47:08"
    description "Maki"
    allday true
    complete false
  end
end
