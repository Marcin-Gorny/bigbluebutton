require 'spec_helper'
require 'fileutils'

module Collector
    describe Presentation do     
        context "#success" do
            it "should copy presentations to archive" do
                FileTest.stub(:directory?).and_return(true)
                FileUtils.stub(:cp_r)
                Dir.stub(:glob).and_return(['flight-school', 'ecosystem'])
                from_dir = 'from'
                to_dir = 'to'
                meeting_id = 'meeting-id'
                
                expect { Collector::Presentation.collect_presentation( meeting_id, from_dir, to_dir ) }.to_not raise_error   
            end
        end
        
        context "#fail" do
            it "should raise from directory not found exception" do
                FileTest.stub(:directory?).and_return(false)
                FileUtils.stub(:cp_r)
                Dir.stub(:glob).and_return(['flight-school', 'ecodystem'])
                from_dir = '/from-dir-not-found'
                to_dir = 'resources/archive'
                meeting_id = 'meeting-id'
                
                expect {Collector::Presentation.collect_presentation( meeting_id, from_dir, to_dir )}.to raise_error(NoSuchDirectoryException)
            end
            it "should raise to directory not found exception" do
                from_dir = 'resources/raw/audio'
                to_dir = '/to-dir-not-found'
                meeting_id = 'meeting-id'
                FileTest.stub(:directory?).and_return(false)
                FileUtils.stub(:cp_r)
                Dir.stub(:glob).and_return(['flight-school', 'ecosystem'])
                
                expect { Collector::Presentation.collect_presentation( meeting_id, from_dir, to_dir ) }.to raise_error(NoSuchDirectoryException)
            end
            it "should raise presentation files not found exception" do
                from_dir = 'resources/raw/audio'
                to_dir = '/to-dir-not-found'
                meeting_id = 'meeting-id'
                FileTest.stub(:directory?).and_return(true)
                FileUtils.stub(:cp)
                Dir.stub(:glob).and_return([])
                
                expect { Collector::Presentation.collect_presentation( meeting_id, from_dir, to_dir ) }.to raise_error(NoPresentationException)
            end
        end
    end
end