# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        columns do
          panel 'Stats' do
            div { link_to "Number of Heroes: #{Hero.count}", admin_heroes_path }
            div { link_to "Number of Abilities: #{Ability.count}", admin_abilities_path }
          end
          div { link_to 'Import/Refresh data', admin_dashboard_import_path }
          div { 'Can take up to 30 seconds' }
        end
      end
    end
  end

  page_action :import do
    DataImportJob.new.perform_now
    redirect_to admin_root_path
  end
end
