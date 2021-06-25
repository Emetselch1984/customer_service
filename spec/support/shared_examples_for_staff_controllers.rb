shared_examples 'a protected admin controller' do |controller|
  let(:args) do
    {
      host: Rails.application.config.system_service[:staff][:host],
      controller: controller
    }
  end
  describe '#index' do
    it 'ログインフォームにリダイレクト' do
      get url_for(args.merge(action: index))
      expect(response).to redirect_to(staff_login_url)
    end
  end
end
