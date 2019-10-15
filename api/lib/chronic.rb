module Chronic
  class Generic
    class << self
      def valid? *dates
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
      def valid? from, to
        return(Chronic.parse(from) < Chronic.parse(to)) if super(*[from, to])
        false
      end
    end
  end
end
