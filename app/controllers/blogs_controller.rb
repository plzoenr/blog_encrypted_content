class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show update ]
  before_action :set_blogs, only: %i[ index export ]

  def index
    @blogs = Blog.all
  end

  def show
  end

  def create
    result = Blogs::ImportService.call(params[:file])

    if result[:success]
      flash.now[:notice] = result[:message]
    else
      flash.now[:error] = result[:message]
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "import_response",
          partial: "blogs/import_response"
        )
      end
    end
  end

  def update
    if @blog.update(blog_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("main_content", partial: "blogs/main_content", locals: { blog: @blog }),
            turbo_stream.replace("blog_error", partial: "blogs/error", locals: { blog: @blog })
          ]
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("blog_error", partial: "blogs/error", locals: { blog: @blog })
          ]
        end
      end
    end
  end

  def export
    # can be implement cache later
    render json: BlogBlueprint.render(@blogs)
  end

  def import
  end

  private

  def set_blog
    @blog = Blog.find_by(slug: params[:slug])
  end

  def set_blogs
    @blogs = Blog.all
  end

  def blog_params
    params.require(:blog).permit([:author, :content])
  end
end
