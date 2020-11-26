module BeerShopWatcher
  class Differentiator
    def initialize(record)
      @record = record
    end

    def self.call(record)
      new(record).call
    end

    def call
      prev_day_result = find_previous_day

      warn if ambiguous?(prev_day_result)

      record[:count] - prev_day_result.first[:count]
    end

    private

    attr_reader :record

    def find_previous_day
      prev_date = record[:created_at].to_date.prev_day.prev_day
      current_record_date = record[:created_at].to_date

      DB[:products]
        .where(Sequel.ilike(:name, "%#{record[:name]}%"))
        .where { (created_at > prev_date) & (created_at < current_record_date) }
    end

    def warn
      AppLogger.warn("#{self.class.name} -- record #{record[:id]} returned ambigious result")
    end

    def ambiguous?(prev_day_result)
      prev_day_result.count > 1
    end
  end
end
