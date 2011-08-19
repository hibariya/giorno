class Admin::EntriesController < ApplicationController
  def index
    @entries = Entry.scoped
  end

  def new
    @entry = Entry.new
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])
    @entry.update_attributes! params[:entry]
  end

  def destroy
    Entry.destroy params[:id]
  end
end
