module Tools
  class TimeHelper

    class << self
      def to_pretty(time)
        return "" unless time
        a = (TIMEZONE.now - TIMEZONE.parse(time.to_s)).to_i

        case a
        when 0 then '刚刚'
        when 1 then '１秒前'
        when 2..59 then a.to_s+'秒前'
        when 60..119 then '１分钟前' #120 = 2 minutes
        when 120..3540 then (a/60).to_i.to_s+'分钟前'
        when 3541..7100 then '１小时前' # 3600 = 1 hour
        when 7101..82800 then ((a+99)/3600).to_i.to_s+'小时前'
        when 82801..172000 then '１天前' # 86400 = 1 day
        when 172001..518400 then ((a+800)/(60*60*24)).to_i.to_s+'天前'
        when 518400..864000 then '１周前' # 518400 = 6 day
        when 864001..2419200 then ((a+180000)/(60*60*24*7)).to_i.to_s+'周前'
        when 2419201..31536000 then ((a+180000)/(60*60*24*30)).to_i.to_s+'月前' # 大于4周按月显示
        else ((a+1800000)/(60*60*24*30*12)).to_i.to_s+'年前' # 大于12月按年显示
        end
      end

      def count_down(time)
        a = (TIMEZONE.parse(time.to_s) - TIMEZONE.now).to_i

        case a
        when 0 then '刚刚'
        when 1 then '１秒后'
        when 2..59 then a.to_s+'秒后'
        when 60..119 then '１分钟内' #120 = 2 minutes
        when 120..3540 then (a/60).to_i.to_s+'分钟后'
        when 3541..7100 then '１小时后' # 3600 = 1 hour
        when 7101..82800 then ((a+99)/3600).to_i.to_s+'小时后'
        else time.strftime('%Y年%m月%d日%H点')
        # else time.strftime("%Y-%m-%d %H:%M:%S")
        # when 82801..172000 then '１天后' # 86400 = 1 day
        # when 172001..518400 then ((a+800)/(60*60*24)).to_i.to_s+'天后'
        # when 518400..1036800 then '１周后'
        # else ((a+180000)/(60*60*24*7)).to_i.to_s+'周后'
        end

      end

    end#self

  end

  # Tools::NumberHeplper
  module NumberHelper

    def yuan_curry_format(amount, precision=0)
      number_to_currency(amount, precision: precision, unit: '¥', delimiter: "")
    end
  end
end
