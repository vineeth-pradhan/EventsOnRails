module Chronic
  class Generic
    class << self
      def valid? *dates
        return false if dates.empty?
        dates.all? { |_| is_it_valid? _ }
      end

      private

      def is_it_valid? date
        !Chronic.parse(date).nil?
      end
    end
  end

  class Event < Generic
    class << self
      def valid? *dates
        return(Chronic.parse(from(dates)) < Chronic.parse(to(dates))) if dates.size == 2 && super(*[from(dates), to(dates)])
        false
      end

      private

      def from dates
        dates[0]
      end

      def to dates
        dates[1]
      end
    end
  end
end
