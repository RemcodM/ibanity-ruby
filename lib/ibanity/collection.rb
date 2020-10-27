module Ibanity
  class Collection < DelegateClass(Array)
    attr_accessor :page_limit,
      :page_number,
      :page_size,
      :total_entries,
      :total_pages,
      :before_cursor,
      :after_cursor,
      :offset,
      :total,
      :first_link,
      :next_link,
      :previous_link,
      :last_link,
      :latest_synchronization,
      :synchronized_at

    def initialize(
      klass:,
      items:,
      paging:,
      links:,
      synchronized_at:,
      latest_synchronization:
    )
      paging                ||= {}
      links                 ||= {}
      @klass                  = klass
      @page_limit             = paging["limit"]
      @page_number            = paging["pageNumber"]
      @page_size              = paging["pageSize"]
      @total_entries          = paging["totalEntries"]
      @total_pages            = paging["totalPages"]
      @before_cursor          = paging["before"]
      @after_cursor           = paging["after"]
      @offset                 = paging["offset"]
      @total                  = paging["total"]
      @first_link             = links["first"]
      @next_link              = links["next"]
      @previous_link          = links["prev"]
      @last_link              = links["last"]
      @synchronized_at        = synchronized_at
      @latest_synchronization = latest_synchronization
      super(items)
    end

    def inspect
      result = "#<#{self.class.name}"
      instance_variables.each do |instance_variable|
        result +=" #{instance_variable}=#{instance_variable_get(instance_variable).inspect}"
      end
      result += ">"
      result
    end
  end
end
