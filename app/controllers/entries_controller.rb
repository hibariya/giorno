class EntriesController < ApplicationController
  def index
    @entries = Entry.scoped

    respond_to do |format|
      format.html
      format.json { render json: @entries.to_json }
      format.rss  { render xml: entries_to_rss(@entries) }
    end
  end

  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: [@entry].to_json }
      format.rss  { render xml: entries_to_rss([@entries]) }
    end
  end

  def entries_to_rss(entries)
    require 'builder'

    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.rdf:RDF, :xmlns        => 'http://purl.org/rss/1.0/',
                 :'xmlns:rdf'  => 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
                 :'xmlns:dc'   => 'http://purl.org/dc/elements/1.1/',
                 :'xmlns:foaf' => 'http://xmlns.com/foaf/0.1/',
                 :'xml:lang'   => 'ja' do

      xml.channel :'rdf:about' => root_url do
        xml.title Settings.title
        xml.link root_url
        xml.dc:date, entries.first.created_at
        xml.description Settings.description
        xml.items do
          xml.rdf:Seq do
            entries.each{|e| xml.rdf:li, :'rdf:resource' => entry_url(e) }
          end
        end
      end

      entries.each do |entry|
        xml.item about: entry_url(entry) do
          xml.title entry.title
          xml.description { xml.cdata! entry.body }
          xml.dc:date, entry.created_at
          xml.link entry_url(entry)
          xml.author Settings.author
        end
      end
    end
  end
end
