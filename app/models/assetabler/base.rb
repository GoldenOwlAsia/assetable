class Assetabler::Base < ActiveRecord::Base
  self.abstract_class = true
  self.table_name_prefix = 'assetable_'
end
