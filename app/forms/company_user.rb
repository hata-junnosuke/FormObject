class CompanyUser
  include ActiveModel::Model
  attr_accessor :company, :user

  delegate :attributes=, to: :company, prefix: true
  delegate :attributes=, to: :user, prefix: true

  def initialize(params = {})
    @company = Company.new(params[:company_attributes])
    @user = User.new(params[:user_attributes]&.merge(company: @company))
  end

  def save
    return false unless valid?

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