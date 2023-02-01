module Api
    class MovesController < ApplicationController
        before_action :set_game
        before_action :set_move, only: [:destroy]
        def index
            @moves = @game.moves
            render 'api/moves/index'
        end
        
        def create
            game = Game.find(params[:game_id])
            move = game.moves.new(move_params)
        
            if move.save
              render json: move
            else
              render json: { errors: move.errors }, status: :unprocessable_entity
            end
          end
    
        def destroy
            @move.destroy
        end
    
        private
    
        def set_game
            @game = Game.find(params[:game_id])
        end
    
        def set_move
            @move = @game.moves.find(params[:id])
        end
    
        def move_params
            params.require(:move).permit(:move)
        end
    end
end