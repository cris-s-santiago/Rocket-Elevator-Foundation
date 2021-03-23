class Customer < ApplicationRecord
    belongs_to :user
    belongs_to :address
    has_many :buildings, dependent: :destroy
    has_many :leads, dependent: :destroy

    # after_create :send_file_to_dropbox
    # after_update :send_file_to_dropbox

    def send_file_to_dropbox
        dropbox = DropboxApi::Client.new
        Lead.where(email: self.email_of_company_contact).each do |lead|
            if !lead.attachment.nil?
                directory = "/Apps/Rocket Elevators API Team 3/" + self.full_name_of_company_contact
                begin
                    dropbox.create_folder directory
                rescue DropboxApi::Errors::FolderConflictError => err #maybe exception
                    #Do nothing as folder already exists
                end
                begin
                    dropbox.upload(directory + "/" + lead.file_name, lead.attachment)
                rescue DropboxApi::Errors::FileConflictError => err #Maybe exception
                    #Do nothing as file already exists
                end

                lead.attachment = nil;
                lead.save!
            end
        end
    end

end
