module RedHillConsulting::ForeignKeyMigrations::ActiveRecord
  module Base
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def references(table_name, column_name, options = {})
        column_name = column_name.to_s
        if options.has_key?(:references)
          references = options[:references]
          pkey = references.to_s.singularize.classify.constantize.primary_key
          references = [references, pkey] unless references.nil? || references.is_a?(Array)
          references
        elsif column_name == 'parent_id'
          t_name = table_name
          pkey = t_name.singularize.classify.constantize.primary_key
          [t_name, pkey]
        elsif column_name =~ /^(.*)_id$/
          t_name = pluralized_table_name($1)
          pkey = t_name.singularize.classify.constantize.primary_key
          [t_name, pkey]
        end
      end
    end
  end
end
