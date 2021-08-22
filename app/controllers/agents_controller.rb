class AgentsController < ApplicationController
   
    def new
        @agent =Agent.new
    end 
    def create
        @agent= Agent.new(params.require(:agent).permit(:name,:email,:phone,:company_id,:role,:password,:password_confirmation))
        
        if @agent.role=="Non-admin"
            @agent.password= @agent.email.split('@',2)[0]
            @agent.password_confirmation=@agent.password
        end 
        if @agent.save
            redirect_to login_index_path
        else

            if @agent.role=="Non-admin"
            flash.alert ="Sub Agent was not created"
            redirect_to companies_path

            else
                flash.alert ="Agent was not created"
                redirect_to login_index_path

            end
        end 


    end

    def addagents
        @agent=Agent.new()
      end

      def destroy 
        @agent = Agent.find(params[:id])

        if @agent.destroy
            redirect_to companies_path
            flash.alert =" Sub Agent has been deleted"
        end
    end 

    

    



end
