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
    
    redirect_to edit_admin_entry_path(@entry)
  end

  def destroy
    Entry.destroy params[:id]

    redirect_to admin_entries_path
  end
end
