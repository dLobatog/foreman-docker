module ForemanDocker
  module Api
    module V2
      class ContainersController < ::Api::V2::BaseController
        before_filter :find_resource, :except => %w{index}

        resource_description do
          resource_id 'containers'
          api_version 'v2'
          api_base_url '/docker/api/v2'
        end

        api :GET, '/containers/', N_('List all containers')
        api :GET, '/compute_resources/:compute_resource_id/containers/',
          N_('List all containers in a compute resource')
        param :compute_resource_id, :identifier
        param_group :pagination, ::Api::V2::BaseController

        def index
          @containers = Container.all
        end

        api :GET, '/containers/:id/', N_('Show a container')
        api :GET, '/compute_resources/:compute_resource_id/containers/:id',
          N_('Show container in a compute resource')
        param :id, :identifier, :required => true
        param :compute_resource_id, :identifier

        def show
        end

        api :POST, '/containers/', N_('Create a container')
        api :POST, '/compute_resources/:compute_resource_id/containers/'
          N_('Create container in a compute resource')
        def_param_group :container do
          param :container, Hash, :required => true, :action_aware => true do
            param :name, String, :required => true
            param :location_id, :number, :required => true, :desc => N_("required if locations are enabled") if SETTINGS[:locations_enabled]
            param :organization_id, :number, :required => true, :desc => N_("required if organizations are enabled") if SETTINGS[:organizations_enabled]
          end
        end

        def create
        end

        api :DELETE, '/containers/:id/', N_('Delete a container')
        api :DELETE, '/compute_resources/:compute_resource_id/containers/:id',
          N_('Delete container in a compute resource')
        param :id, :identifier, :required => true
        param :compute_resource_id, :identifier

        def destroy
        end

        api :GET, '/containers/:id/logs', N_('Show container logs')
        api :GET, '/compute_resources/:compute_resource_id/containers/:id/logs',
          N_('Show logs from a container in a compute resource')
        param :id, :identifier, :required => true
        param :compute_resource_id, :identifier

        def log
        end

        api :PUT, '/containers/:id/power', N_('Run power operation on a container')
        api :PUT, '/compute_resources/:compute_resource_id/containers/:id/power',
          N_('Run power operation on a container in a compute resource')
        param :id, :identifier, :required => true
        param :compute_resource_id, :identifier
        param :power_action, String, :required => true, :desc => N_('power action, valid actions are (start), (stop), (status)')

        def power
        end

        private

        def action_permission
          case params[:action]
          when :log
            :show
          when :power
            :edit
          else
            super
          end
        end
      end
    end
  end
end
