class ResumesController < ApplicationController
   def index
      if params && params[:req]
         render :js => "window.location = '#{resumes_dene_path}'"
      end
      @resumes = Resume.all
   end
   
   def new
     @resume = Resume.new
   end
   
  
   def create
      @resume = Resume.new(resume_params)
      #raise @resume.inspect
      if @resume.save
         redirect_to resumes_path, notice: "The project #{@resume.name} has been uploaded."
         unzip_file(params[:resume][:attachment].tempfile, "C:/Users/buse/Desktop/oldu/")

      else
         render 'new'
      end
      
   end
   
   def destroy
      @resume = Resume.find(params[:id])
      @resume.destroy
      redirect_to resumes_path, notice:  "The project #{@resume.name} has been deleted."
     # redirect_to post_url(@post), status: :dene

   end

   private
      def resume_params
      params.require(:resume).permit(:name, :attachment)
   end

   def unzip_file(file_path,destination_path)
      Zip::ZipFile.open(file_path) { |zip_file|
        zip_file.each { |f|
          f_path=File.join(destination_path, f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exist?(f_path)
        }
      }

    def dir_entries(source_path)
      files = Dir["C:/Users/buse/Desktop/oldu/"]
      puts files
    end

    end

    def dene
    end


   end