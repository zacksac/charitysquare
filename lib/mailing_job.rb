class MailingJob < Struct.new(:user_id, :mailing_id, :amount)
  def perform

   # make the bet inactive #
   Bet.find(mailing_id).update_attributes!(:active => false)

   # end #
          # @inv_users = InvitedUser.where(:bet_id => mailing_id)
          # if BetResponse.find_by_bet_id(mailing_id).user_id == user_id
          #   if BetResult.find_by_bet_id(mailing_id).present? == true
          #     if BetResult.find_by_bet_id(mailing_id).answer == BetResponse.where('bet_id = ? and user_id = ?', mailing_id, user_id).first.response
          #       UserMailer.bet_result(User.find_by_id(user_id).email, "win", mailing_id, amount).deliver
          #     else 
          #       UserMailer.bet_result(User.find_by_id(user_id).email, "lose", mailing_id, amount).deliver
          #     end
          #   end 
          # end  
      # if @inv_users.count == 1                                           
      #       if BetResult.find_by_bet_id(mailing_id).answer == BetResponse.find_by_user_id(@inv_users.first.user_id).response
      #          UserMailer.bet_result(User.find(@inv_users.first.user_id).email, "win", mailing_id, amount).deliver           
      #         # UserMailer.bet_result(User.find(@inv_users.first.user_id).email, "win").deliver
      #       else  
      #         UserMailer.bet_result(User.find(@inv_users.first.user_id).email, "lose", mailing_id, amount).deliver
      #       end
      # else
        # if !@inv_users.nil?
        #   @inv_users.each do |i|
        #   if BetResult.find_by_bet_id(mailing_id).present? == true 
        #     if BetResult.find_by_bet_id(mailing_id).answer == BetResponse.where('bet_id = ? and user_id = ?', mailing_id, i.user_id).first.response
        #       UserMailer.bet_result(User.find_by_id(i.user_id).email, "win", mailing_id, amount).deliver
        #     else 
        #       UserMailer.bet_result(User.find_by_id(i.user_id).email, "lose", mailing_id, amount).deliver
        #     end
        #    end 
        #   end 
        # end

      # end 
    
   end
end