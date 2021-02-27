/// @param matrix
/// @param x
/// @param y
/// @param z
/// @param w
function MatrixTransformVertex(_matrix, _x_in, _y_in, _z_in, _w_in)
{
    var _x = _x_in*_matrix[0] + _y_in*_matrix[4] + _z_in*_matrix[ 8] + _w_in*_matrix[12];
    var _y = _x_in*_matrix[1] + _y_in*_matrix[5] + _z_in*_matrix[ 9] + _w_in*_matrix[13];
    var _z = _x_in*_matrix[2] + _y_in*_matrix[6] + _z_in*_matrix[10] + _w_in*_matrix[14];
    var _w = _x_in*_matrix[3] + _y_in*_matrix[7] + _z_in*_matrix[11] + _w_in*_matrix[15];
    
    return [_x, _y, _z, _w];
}

function Vec2Add(_a, _b)
{
    return [_a[0] + _b[0], _a[1] + _b[1]];
}

function Vec2Sub(_a, _b)
{
    return [_a[0] - _b[0], _a[1] - _b[1]];
}

#macro VECTOR_PROJ_MATRIX_NEGATIVE_Y  ((os_type == os_windows) || (os_type == os_xboxone))

function TargetCurrentWidth()
{
    var _surface = surface_get_target();
    return (_surface < 0)? window_get_width() : surface_get_width(_surface);
}

function TargetCurrentHeight()
{
    var _surface = surface_get_target();
    return (_surface < 0)? window_get_height() : surface_get_height(_surface);
}

function TargetCurrentProjectionScale()
{
    return TargetProjectionScale(TargetCurrentWidth(), TargetCurrentHeight(), matrix_get(matrix_projection));
}

function TargetProjectionScale(_surfaceWidth, _surfaceHeight, _projectionMatrix)
{
    var _result = matrix_transform_vertex(_projectionMatrix, 0.5*_surfaceWidth, -0.5*_surfaceHeight, 0);
    _result[1] = abs(_result[1]); //Stupid GM
    return _result;
}

/// @param vector
/// @param [surfaceWidth]
/// @param [surfaceHeight]
/// @param [forceNegativeY]
function Vec2ToScreen()
{
    var _vector        = argument[0];
    var _surfaceWidth  = (argument_count > 1)? argument[1] : undefined;
    var _surfaceHeight = (argument_count > 2)? argument[2] : undefined;
    var _negativeY     = ((argument_count > 3) && (argument[3] != undefined))? argument[0] : VECTOR_PROJ_MATRIX_NEGATIVE_Y;
    
    if (_surfaceWidth  == undefined) _surfaceWidth  = TargetCurrentWidth();
    if (_surfaceHeight == undefined) _surfaceHeight = TargetCurrentHeight();
    if (_negativeY) _surfaceHeight *= -1.0;
    
    return [0.5*_surfaceWidth *_vector[0],
            0.5*_surfaceHeight*_vector[1]];
}

/// @param vector
/// @param [surfaceWidth]
/// @param [surfaceHeight]
/// @param [forceNegativeY]
function Vec3ToScreen()
{
    var _vector        = argument[0];
    var _surfaceWidth  = (argument_count > 1)? argument[1] : undefined;
    var _surfaceHeight = (argument_count > 2)? argument[2] : undefined;
    var _negativeY     = ((argument_count > 3) && (argument[3] != undefined))? argument[0] : VECTOR_PROJ_MATRIX_NEGATIVE_Y;
    
    if (_surfaceWidth  == undefined) _surfaceWidth  = TargetCurrentWidth();
    if (_surfaceHeight == undefined) _surfaceHeight = TargetCurrentHeight();
    if (_negativeY) _surfaceHeight *= -1.0;
    
    return [0.5*_surfaceWidth *_vector[0],
            0.5*_surfaceHeight*_vector[1]];
}

/// @param vector
/// @param [surfaceWidth]
/// @param [surfaceHeight]
/// @param [forceNegativeY]
function Vec4ToScreen()
{
    var _vector        = argument[0];
    var _surfaceWidth  = (argument_count > 1)? argument[1] : undefined;
    var _surfaceHeight = (argument_count > 2)? argument[2] : undefined;
    var _negativeY     = ((argument_count > 3) && (argument[3] != undefined))? argument[0] : VECTOR_PROJ_MATRIX_NEGATIVE_Y;
    
    if (_surfaceWidth  == undefined) _surfaceWidth  = TargetCurrentWidth();
    if (_surfaceHeight == undefined) _surfaceHeight = TargetCurrentHeight();
    if (_negativeY) _surfaceHeight *= -1.0;
    
    return [0.5*_surfaceWidth *_vector[0]/_vector[3],
            0.5*_surfaceHeight*_vector[1]/_vector[3]];
}

#macro MATRIX_STRING_FORMAT_TOTAL  4
#macro MATRIX_STRING_FORMAT_DEC    7

function MatrixToString(_matrix)
{
    return "[" + string_format(_matrix[ 0], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_matrix[ 1], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_matrix[ 2], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_matrix[ 3], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + "\n " +
                 string_format(_matrix[ 4], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_matrix[ 5], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_matrix[ 6], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_matrix[ 7], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + "\n " +
                 string_format(_matrix[ 8], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_matrix[ 9], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_matrix[10], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_matrix[11], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + "\n " +
                 string_format(_matrix[12], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_matrix[13], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_matrix[14], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_matrix[15], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + "]";
}

function Vec2ToString(_vector)
{
    return "(" + string_format(_vector[0], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_vector[1], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ")";
}

function Vec3ToString(_vector)
{
    return "(" + string_format(_vector[0], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_vector[1], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_vector[2], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ")";
}

function Vec4ToString(_vector)
{
    return "(" + string_format(_vector[0], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_vector[1], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_vector[2], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ", " + string_format(_vector[3], MATRIX_STRING_FORMAT_TOTAL, MATRIX_STRING_FORMAT_DEC) + ")";
}