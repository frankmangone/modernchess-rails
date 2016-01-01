class RoomSerializer < ActiveModel::Serializer
  #attributes :type, :id#, :token, :game_type, :board

  #def type
  #	object.game_type + "/rooms"
  #end

  #def id
  #  object.token
  #end
  
  #def attributes
  #	data = super
  #	data[:attributes] = {
  #		# object is the target model
  #		game_type: object.game_type,
  #		board:     object.board,
  #   turn:      object.turn
  #	}
  #	data 
  #end

  attributes :id, :game_type, :turn, :board

  def id
    object.token
  end

  #def type
  # object.game_type + "/rooms"
  #end
end
