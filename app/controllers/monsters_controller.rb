class MonstersController < InheritedResources::Base

  def index
    @monsters = Monster.all
  end

  def show
    @monster = Monster.find(params[:id])
  end

  private

    def monster_params
      params.require(:monster).permit(:name, :no, :evolution_from_id)
    end
end

