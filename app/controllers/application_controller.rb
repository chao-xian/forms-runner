# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Services::UserIpService
  include Services::MaintenanceModeService
  include Services::HeaderService

  before_action :set_request_id
  before_action :check_maintenance_mode_is_enabled
  after_action :add_robots_header

  def accessibility_statement; end

  def cookies; end
end
