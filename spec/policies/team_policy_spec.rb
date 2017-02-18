require 'rails_helper'

describe TeamPolicy do
  subject { TeamPolicy.new(user, team) }

  let(:team) { FactoryGirl.create(:team) }

  context "being a visitor" do
    let(:user) { nil }

    it { is_expected.to forbid_action(:show)    }
    it { is_expected.to forbid_action(:create)  }
    it { is_expected.to forbid_action(:new)     }
    it { is_expected.to forbid_action(:update)  }
    it { is_expected.to forbid_action(:edit)    }
    it { is_expected.to forbid_action(:destroy) }
  end

  context "being an unenrolled user" do
    let(:user) { FactoryGirl.create(:user) }

    it { is_expected.to forbid_action(:show)    }
    it { is_expected.to permit_action(:create)  }
    it { is_expected.to permit_action(:new)     }
    it { is_expected.to forbid_action(:update)  }
    it { is_expected.to forbid_action(:edit)    }
    it { is_expected.to forbid_action(:destroy) }
  end

  context "being an enrolled user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:enrollment) { FactoryGirl.create(:enrollment) }

    it { is_expected.to permit_action(:show)    }
    it { is_expected.to permit_action(:create)  }
    it { is_expected.to permit_action(:new)     }
    it { is_expected.to forbid_action(:update)  }
    it { is_expected.to forbid_action(:edit)    }
    it { is_expected.to forbid_action(:destroy) }
  end

  context "being an admin" do
    let(:user) { FactoryGirl.create(:admin) }

    it { is_expected.to permit_action(:show)    }
    it { is_expected.to permit_action(:create)  }
    it { is_expected.to permit_action(:new)     }
    it { is_expected.to permit_action(:update)  }
    it { is_expected.to permit_action(:edit)    }
    it { is_expected.to permit_action(:destroy) }
  end
end
