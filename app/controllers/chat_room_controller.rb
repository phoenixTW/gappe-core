class ChatRoomController < ApplicationController
  before_action :authenticate_user!

  def index
    @chat_rooms = ChatRoom.all
    render json: @chat_rooms
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      render json: @chat_room
    else
      render json: :internal_server_error
    end
  end

  private

  def chat_room_params
    params.permit(:title)
  end
end
