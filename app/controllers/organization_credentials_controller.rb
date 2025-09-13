class OrganizationCredentialsController < ApplicationController
  before_action :set_organization_credential, only: [ :show, :edit, :update, :destroy ]

  def index
    @organization_credentials = OrganizationCredential.all
  end

  def show
  end

  def new
    @organization_credential = OrganizationCredential.new
  end

  def create
    @organization_credential = OrganizationCredential.new(organization_credential_params)

    if @organization_credential.save
      redirect_to @organization_credential, notice: "Organization credential was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @organization_credential.update(organization_credential_params)
      redirect_to @organization_credential, notice: "Organization credential was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @organization_credential.destroy
    redirect_to organization_credentials_url, notice: "Organization credential was successfully deleted."
  end

  private

  def set_organization_credential
    @organization_credential = OrganizationCredential.find(params[:id])
  end

  def organization_credential_params
    params.require(:organization_credential).permit(:title, :username, :password, :password_confirmation)
  end
end
