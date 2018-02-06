class BugsController < ApplicationController
  before_action :set_bug, only: [:show, :edit, :update, :destroy]

  # GET /bugs
  # GET /bugs.json
  def index
    @bugs = Bug.all
  end

  # GET /bugs/1
  # GET /bugs/1.json
  def show
  end

  # GET /bugs/new
  def new
    @bug = Bug.new
  end

  # GET /bugs/1/edit
  def edit

  end

  # POST /bugs
  # POST /bugs.json
  def create
    @bug = Bug.new(bug_params)

    respond_to do |format|
      if @bug.save
        format.html { redirect_to @bug, notice: 'Bug adicionado com sucesso!' }
        format.json { render :show, status: :created, location: @bug }
    
       notifier = Slack::Notifier.new "https://hooks.slack.com/services/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" do
  defaults channel: "#general",
         username: "notifier"
        end
        notifier.ping("Foi adicionado um bug no projeto " + @bug.projeto.nome + " cujo a descrição é " + @bug.descricao)
      else
        format.html { render :new }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bugs/1
  # PATCH/PUT /bugs/1.json
  def update
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to @bug, notice: 'Bug foi resolvido com sucesso!' }
        format.json { render :show, status: :ok, location: @bug }

       if @bug.solucionado
       notifier = Slack::Notifier.new "https://hooks.slack.com/services/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" do
  defaults channel: "#general",
         username: "notifier"
        end
        notifier.ping("O bug " + @bug.descricao + " foi solucionado - Projeto " + @bug.projeto.nome  + "\n A solução foi: "+ @bug.solucao)
      end

      else
        format.html { render :edit }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1
  # DELETE /bugs/1.json
  def destroy
    @bug.destroy
    respond_to do |format|
      format.html { redirect_to bugs_url, notice: 'Bug deletado com sucesso!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @bug = Bug.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bug_params
      params.require(:bug).permit(:descricao, :solucionado, :solucao, :projeto_id)
    end
end
