require 'spec_helper'
require 'active_record'
require 'tphases/modes/pass_through_mode'

describe TPhases::Modes::PassThroughMode do
  subject { Module.new { include TPhases::Modes::PassThroughMode } }

  include_context "setup mode specs"

  describe '.no_transactions_phase, .read_phase, .write_phase' do
    it "should allow anything and return the block" do
      subject.no_transactions_phase do
        ActiveRecord::Base.connection.select_all(read_sql)
        ActiveRecord::Base.connection.select_all(write_sql)
        :return_val
      end.should == :return_val

      subject.write_phase do
        ActiveRecord::Base.connection.select_all(read_sql)
        ActiveRecord::Base.connection.select_all(write_sql)
        :return_val
      end.should == :return_val

      subject.read_phase do
        ActiveRecord::Base.connection.select_all(read_sql)
        ActiveRecord::Base.connection.select_all(write_sql)
        :return_val
      end.should == :return_val

      subject.ignore_phases do
        ActiveRecord::Base.connection.select_all(read_sql)
        ActiveRecord::Base.connection.select_all(write_sql)
        :return_val
      end.should == :return_val

    end

  end
end