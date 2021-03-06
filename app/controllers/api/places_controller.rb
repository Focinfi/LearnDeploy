class Api::PlacesController < Lina::ApplicationController
  # def index
  define_action :index, {
    name: '请求读觅Place列表',
    description: '选择：全部 或 分页 数据',
    params: {
      type: 'object',
      properties: {
        page: {
          type: 'string',
          description: '页码，数字字符串'
        },
        per_page: {
          type: 'string',
          description: '每页Place数量，注意是从第一个算起'
        }
      }
    },
    return: {
      name: "显示读觅Place列表",
      description: '返回：全部 或 分页 数据',
      type: 'array',
      properties: {
        id: {
          type: 'integer'
        },
        name: {
          type: 'string'
        },
        category: {
          type: 'string'
        },
        latitude: {
          type: 'number',
          description: '纬度'
        },
        longitude: {
          type: 'number',
          description: '经度'
        },
        business_hours: {
          type: 'string',
          description: '营业时间段'
        },
        description: {
          type: 'string'
        },
        picture_01_url: {
          type: 'string'
        },
        picture_02_url: {
          type: 'string'
        },
        picture_03_url: {
          type: 'string'
        },
        html_url: {
          type: 'string',
          description: "host ip 与API相同，此字段为uri"
        },
        created_at: {
          type: 'string'
        },
        address: {
          type: 'string'
        },
        contact: {
          type: 'string'
        }
      }
    }
    } do
      page = params[:page]
      per_page = params[:per_page]
      
      # handle invalid params
      begin
        Integer(page) if page
        Integer(per_page) if per_page
      rescue Exception
        render json: { error: "page或per_page参数不是数字字符串", status: "400" }
        return
      end

      # set @places
      per_page ||= 10
      if page
        @places = Place.paginate(page: page, per_page: per_page)
      else
        @places = Place.all
      end
    end

  define_action :create, {
    name: '提交一个新的读觅地点',
    description: '传入一些信息，新建一个读觅地点',
    params: {
      type: 'object',
      required: [ :name, :latitude, :longitude, :category ],
      properties: {
        name: {
          type: 'string'
        },

        business_hours: {
          type: 'string',
          description: '营业时间'
        },

        description: {
          type: 'string',
          description: '地点简介'
        },

        latitude: {
          type: 'string'
        },

        longitude: {
          type: 'string'
        },

        category: {
          type: 'string',
          enum: Place::CATEGORY_TYPES
        }, 

        picure_01: {
          type: 'object',
          description: '第一张图片'
        },

        picure_02: {
          type: 'object',
          description: '第一张图片'
        },

        picure_03: {
          type: 'object',
          description: '第三张图片'
        }
      }
    },
    return: {
      name: "反馈新建结果",
      type: 'object',
      required: [ :created, :status ],
      properties: {
        created: {
          type: 'boolean',
        },

        status: {
          type: 'string'
        }
      }
    }
    } do
      # # render json: { type: params.to_s }
      if Place.new(place_params).save
        render json: { created: true, status: "200" }
      else
        render json: { created: false, status: "400" }
      end

    end

  define_action :upload, {
    name: '上传一个简单地点',
    params: {
      type: 'object',
      required: [ :name, :description ],
      properties: {
        name: {
          type: 'string'
        },

        description: {
          type: 'string'
        },

        picture_01: {
          type: 'object'
        }
      }      
    },
    return: {
      name: "返回新建结果",
      type: 'object',
      required: [ :created, :status ],
      properties: {
        created: {
          type: 'string'
        },

        status: {
          type: 'string'
        }
      }
    }
    } do 
      if simple_place_params[:name] && simple_place_params[:description]
        if Place.new(simple_place_params).save
          render json: { created: true, status: "200" }
        else
          render json: { created: false, status: "400" }
        end
      else
        render json: { created: false, status: "400" }
      end
  end

  private
  def place_params
    params.permit(:name, :latitude, :longitude, :business_hours, 
        :description, :author, :category, :picture_01, :picture_02, :picture_03)
  end

  def simple_place_params
    params.permit(:name, :description, :picture_01).merge({ flag: 'recommended', category: "其他" })
  end


end
