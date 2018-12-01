# frozen_string_literal: true

# An article is an element which can be ordered and displayed via a Catalog
class Article < ApplicationRecord
  # associations
  has_many :article_publications, inverse_of: :article, dependent: :destroy
  has_many :catalogs, through: :article_publications
  # associations: users
  # [TMP-001] optional: true https://stackoverflow.com/a/35775686/4906586
  belongs_to :user, inverse_of: :catalogs, optional: false

  # validations
  validates_presence_of :name

  # Scopes
  scope :for_name, -> (name) { where('name like ?', "#{name}%") }
end
