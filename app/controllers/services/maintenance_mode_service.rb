module Services
  module MaintenanceModeService
    def check_maintenance_mode_is_enabled
      if Settings.maintenance_mode.enabled && non_maintenance_bypass_ip_address?
        redirect_to maintenance_page_path
      end
    end

    def non_maintenance_bypass_ip_address?
      bypass_ips = Settings.maintenance_mode.bypass_ips

      return true if bypass_ips.blank?

      bypass_ip_list = bypass_ips.split(",").map { |ip| IPAddr.new ip.strip }
      bypass_ip_list.none? { |ip| ip.include?(user_ip(request.env.fetch("HTTP_X_FORWARDED_FOR", ""))) }
    end
  end
end
