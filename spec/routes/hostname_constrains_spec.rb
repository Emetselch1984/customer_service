require 'rails_helper'

describe 'routes', type: :routing do
  it '職員トップページ' do
    config = Rails.application.config.system_service
    url = "http://#{config[:staff][:host]}/#{config[:staff][:path]}"
    # expect(url).to eq ""
    expect(get: url).to route_to(
      host: config[:staff][:host],
      controller: 'staff/top',
      action: 'dashboard'
    )
  end
  it '管理人トップページ' do
    config = Rails.application.config.system_service
    url = "http://#{config[:admin][:host]}/#{config[:admin][:path]}"
    # expect(url).to eq ""
    expect(get: url).to route_to(
      host: config[:admin][:host],
      controller: 'admin/top',
      action: 'index'
    )
  end
  it '管理人トップページ' do
    config = Rails.application.config.system_service
    url = "http://#{config[:customer][:host]}/#{config[:customer][:path]}"
    # expect(url).to eq ""
    expect(get: url).to route_to(
      host: config[:customer][:host],
      controller: 'customer/top',
      action: 'index'
    )
  end
  it 'ホスト名が違う' do
    url = 'http::/foo@example.com'
    expect(get: url).not_to be_routable
  end
  it 'パスが違う' do
    config = Rails.application.config.system_service
    url = "http://#{config[:customer][:host]}/xyz"
    expect(get: url).not_to be_routable
  end
end
