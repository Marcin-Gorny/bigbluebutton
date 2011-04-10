
module BigBlueButton
  class Archiver
    def meeting_recorded?(meeting_id)
      return true
    end
    
    def archive(meeting_id)
      BigBlueButton::AudioArchiver.archive(meeting_id, from, to)
      BigBlueButton::EventsArchiver.archive(meeting_id, to)
      BigBlueButton::PresentationArchiver.archive(meeting_id, from, to)
      BigBlueButton::VideoArchiver.archive(meeting_id, from, to)
      BigBlueButton::DeskshareArchiver.archive(meeting_id, from, to)
    end
  end
  
  class AudioArchiver  
    def self.archive(meeting_id, from, archive_dir)
      to_dir = "#{archive_dir}/#{meeting_id}/audio"
      if not FileTest.directory?(to_dir)
        FileUtils.mkdir_p to_dir
      end
      puts "Archiving #{meeting_id} from #{from} to #{to_dir}"
      Collector::Audio.collect_audio(meeting_id, from, to_dir)
    end
  end
  
  class EventsArchiver
    def self.archive(meeting_id)
      true
    end
  end
  
  class PresentationArchiver
    def self.archive(meeting_id, from, archive_dir)
      to_dir = "#{archive_dir}/#{meeting_id}/presentations"
      if not FileTest.directory?(to_dir)
        FileUtils.mkdir_p to_dir
      end
      puts "Archiving #{meeting_id} from #{from} to #{to_dir}"
      Collector::Presentation.collect_presentation(meeting_id, from, to_dir)
    end
  end
  
  class VideoArchiver
    def self.archive(meeting_id, from, archive_dir)
      to_dir = "#{archive_dir}/#{meeting_id}/video"
      if not FileTest.directory?(to_dir)
        FileUtils.mkdir_p to_dir
      end
      puts "Archiving #{meeting_id} from #{from} to #{to_dir}"
      Collector::Video.collect_video(meeting_id, from, to_dir)    
    end
  end

  class DeskshareArchiver
    def self.archive(meeting_id, from, archive_dir)
      to_dir = "#{archive_dir}/#{meeting_id}/deskshare"
      if not FileTest.directory?(to_dir)
        FileUtils.mkdir_p to_dir
      end
      puts "Archiving #{meeting_id} from #{from} to #{to_dir}"
      Collector::Deskshare.collect_deskshare(meeting_id, from, to_dir)    
    end
  end
  
end
