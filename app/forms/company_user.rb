class CompanyUser
  include ActiveModel::Model
  # fields_forで使うため
  attr_accessor :company, :user

  # これによって:company_attributesで情報を持ってこれる。（:userも同様）
  delegate :attributes=, to: :company, prefix: true
  delegate :attributes=, to: :user, prefix: true

  def initialize(params = {})
    @company = Company.new(params[:company_attributes])
    @user = User.new(params[:user_attributes]&.merge(company: @company))
  end

  def save
    return false unless valid?
    # トランザクションの記述
    ActiveRecord::Base.transaction do
      @company.save!
      @user.save!
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def valid?
    super
    [@user.valid?, @company.valid?].all?
  end

end