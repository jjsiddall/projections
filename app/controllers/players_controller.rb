class PlayersController < ApplicationController
  # GET /players
  # GET /players.json
  def index
    @players = Player.where(source: params[:source].upcase, stat_year: params[:year]).order('fpoints desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @players }
      format.csv { 
        send_data(
          Player.to_csv(@players),
          :type => 'application/excel',
          :filename => 'players.csv',
          :disposition => 'attachment'
        ) 
      }
    end
  end
  def quarterbacks
    @players = Player.where(source: params[:source].upcase, position: 'QB', stat_year: params[:year]).order('fpoints desc')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @players }
      format.csv { 
        send_data(
          Player.to_csv(@players),
          :type => 'application/excel',
          :filename => 'players.csv',
          :disposition => 'attachment'
        ) 
      }
    end
  end
  def runningbacks
    @players = Player.where(source: params[:source].upcase, position: 'RB', stat_year: params[:year]).order('fpoints desc')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @players }
      format.csv { 
        send_data(
          Player.to_csv(@players),
          :type => 'application/excel',
          :filename => 'players.csv',
          :disposition => 'attachment'
        ) 
      }
    end
  end
  def widereceivers
    @players = Player.where(source: params[:source].upcase, position: 'WR', stat_year: params[:year]).order('fpoints desc')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @players }
      format.csv { 
        send_data(
          Player.to_csv(@players),
          :type => 'application/excel',
          :filename => 'players.csv',
          :disposition => 'attachment'
        ) 
      }
    end
  end
  def tightends
    @players = Player.where(source: params[:source].upcase, position: 'TE', stat_year: params[:year]).order('fpoints desc')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @players }
      format.csv { 
        send_data(
          Player.to_csv(@players),
          :type => 'application/excel',
          :filename => 'players.csv',
          :disposition => 'attachment'
        ) 
      }
    end
  end
  def defenses
    @players = Player.where(source: params[:source].upcase, position: 'D/ST', stat_year: params[:year]).order('fpoints desc')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @players }
      format.csv { 
        send_data(
          Player.to_csv(@players),
          :type => 'application/excel',
          :filename => 'players.csv',
          :disposition => 'attachment'
        ) 
      }
    end
  end
  def kickers
    @players = Player.where(source: params[:source].upcase, position: 'K', stat_year: params[:year]).order('fpoints desc')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @players }
      format.csv { 
        send_data(
          Player.to_csv(@players),
          :type => 'application/excel',
          :filename => 'players.csv',
          :disposition => 'attachment'
        ) 
      }
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @player }
    end
  end

  # GET /players/new
  # GET /players/new.json
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render json: @player, status: :created, location: @player }
      else
        format.html { render action: "new" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.json
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end

  # scrappers
  def espn_scrap
    Player.where(source: "ESPN").delete_all
    player = Player.new
    player.espnDataPull
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'ESPN Players successfully imported' }
    end
  end
  def cbs_scrap
    Player.where(source: "CBS").delete_all
    player = Player.new
    @players = player.cbsDataPull
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'CBS Players successfully imported' }
    end
  end
end
