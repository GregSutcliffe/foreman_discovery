class DiscoveryRule < ActiveRecord::Base
  include Authorizable
  extend FriendlyId
  friendly_id :name
  include Parameterizable::ByIdName

  attr_accessible :name, :enabled, :hostgroup_id, :hostname, :max_count, :priority, :search

  validates :name, :presence => true, :uniqueness => true,
    :format => { :with => /\A(\S+)\Z/, :message => N_("can't contain white spaces.") }
  validates :search, :presence => true
  validates :hostgroup_id, :presence => true
  validates :hostname, :presence => true
  validates :max_count, :numericality => { only_integer: true }
  validates :priority, :presence => true, numericality: true
  validates_lengths_from_database

  belongs_to :hostgroup
  has_many :hosts

  scoped_search :on => :name, :complete_value => :true
  scoped_search :on => :priority
end
