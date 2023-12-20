class ProjectsDraftsController < ApplicationController
    def index
      @drafts = ProjectsDraft.all
    end

    def show
      @draft = ProjectsDraft.find(params["id"])
      return render "show"
    end
  
    def new
      @draft = ProjectsDraft.new
    end
  
    def create
      @draft = ProjectsDraft.where(project_id: draft_params[:project_id], state: ["Aprovado", "Analisando"])
      
      if @draft.present?
        @draft.each do |draft_project|
          if draft_project.state == "Aprovado"
            redirect_to ("/project/#{draft_params["project_id"]}/drafts/new"); return
          else
            if draft_project.state == "Analisando"
              redirect_to ("/project/#{draft_params["project_id"]}/drafts/new"); return
            else
              @draft = ProjectsDraft.new(draft_params)
              if @draft.save
                redirect_to ("/projects/#{draft_params["project_id"]}"); return
              else
                render :new
              end
            end
          end
        end
      else
        @draft = ProjectsDraft.new(draft_params)
        if @draft.save
          redirect_to ("/projects/#{draft_params["project_id"]}"); return
        else
          render :new
        end
      end
    end
  
    def edit
      @draft = ProjectsDraft.find(params[:id])
    end
  
    def update
      @draft = ProjectsDraft.find(params[:id])
      if @draft.update(draft_params)
        redirect_to projects_drafts_path
      else
        render :edit
      end
    end
  
    def destroy
      @draft = ProjectsDraft.find(params[:id])
      @draft.destroy
      redirect_to projects_drafts_path
    end
  
    private

    def set_draft
      @draft = ProjectsDraft.find(params[:id])
    end
  
    def draft_params
      params.require(:projects_draft).permit(
        :project_id, :theme, :introduction, :problem, :study_object, :action_field,
        :general_objective, :specific_objective, :justification, :hypothesis, :variables,
        :methodology, :search, :methods, :techniques, :structure, :references, :state
      )
    end
  end
  