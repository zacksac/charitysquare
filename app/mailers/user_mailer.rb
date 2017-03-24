class UserMailer < ActionMailer::Base
 default from: 'noreply@example.com'
  def welcome_email(params)
    @params = params
    @user_kkk='ritika@esferasoft.com'
    @url  = 'http://example.com/login'
    mail(to: @params.email, subject: 'Welcome email' )
    # mail(to: @user_kkk, subject: 'Welcome email', body: @params )

  end

  def invite(params, user, bet_id)
    @params =  params 
    @bet_id = bet_id
    @user_id = user.id
    mail(to: user.email, subject: 'Invitation')
  end 

  def invite1(params, user, bet_id)
    @params =  params 
    mail(to: user, subject: 'Invitation1')
  end 

  def bet_result1(result, result1)
    user="ritika@esferasoft.com"
    mail(to: user , subject: result1, body: result)
  end

  def bet_result(response, bet_result)
    @bet_id = response.bet_id
    @amount = Bet.find(response.bet_id).amount
    @answer = response.response
    @userid = response.user_id
    @email = User.find(@userid).email
    @bet_result = bet_result
    # if @answer == "win"
    #   @ans = true
    # else 
    #   @ans = false
    # end    

    # if BetResult.find_by_bet_id(bet_id).answer == @ans 
    #   mail(to: email, subject: 'Bet Result')
    # else 
    #   mail(to: email, subject: 'Bet Result')
    # end

    if @answer == @bet_result 
      mail(to: @email, subject: 'Bet Result')
    else 
      mail(to: @email, subject: 'Bet Result')
    end
  end 
end


