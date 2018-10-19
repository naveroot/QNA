require 'rails_helper'

RSpec.describe Question, type: :model do
 it { should validates_presence_of :title }
 it { should validates_presence_of :body }

 it { should have_many(:answers).dependent(:destroy) }
end
