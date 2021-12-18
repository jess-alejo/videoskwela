# frozen_string_literal: true

require "rails_helper"

RSpec.describe Review, type: :model do
  it { is_expected.to have_db_column(:reviewable_id).of_type(:integer) }
  it { is_expected.to have_db_column(:reviewable_type).of_type(:string) }

  it { is_expected.to belong_to(:reviewable) }
end
