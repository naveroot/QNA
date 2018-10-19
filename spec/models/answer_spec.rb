require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validates_presence_of :body }

  it { should belong_to :question }

end
