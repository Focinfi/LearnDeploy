# == Schema Information
#
# Table name: html_urls
#
#  id         :integer          not null, primary key
#  place_id   :integer
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe HtmlUrl, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
